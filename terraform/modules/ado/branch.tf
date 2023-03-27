// This resource creates a Git repository in the ADO project, and sets the default branch to "refs/heads/main".
resource "azuredevops_git_repository" "repo" {
  project_id     = azuredevops_project.this.id
  name           = local.ado_repository_name
  default_branch = "refs/heads/main"
  initialization {
    init_type = "Clean"
  }
}

// This resource creates a new Git branch in the repository, named "feature", and sets the branch to track the default branch.
resource "azuredevops_git_repository_branch" "branch" {
  depends_on    = [azuredevops_git_repository.repo]
  repository_id = azuredevops_git_repository.repo.id
  name          = "feature"
  ref_branch    = azuredevops_git_repository.repo.default_branch
}

// This resource creates a branch policy that requires a build to pass before changes can be merged into the default branch. The build definition is set to the one for the "feature" branch, and it only applies to the default branch of the repository.
resource "azuredevops_branch_policy_build_validation" "validation" {
  project_id = azuredevops_project.this.id
  enabled    = true
  blocking   = true

  settings {
    display_name        = "Feature branch validation"
    build_definition_id = azuredevops_build_definition.pipeline["feature"].id
    valid_duration      = 0
    scope {
      repository_id  = azuredevops_git_repository.repo.id
      repository_ref = azuredevops_git_repository.repo.default_branch
      match_type     = "Exact"
    }
  }
  depends_on = [azuredevops_git_repository_file.file]
}