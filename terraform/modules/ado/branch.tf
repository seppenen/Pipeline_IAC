
//ADO branch & policy definitions

resource "azuredevops_git_repository" "repo" {
  project_id     = azuredevops_project.this.id
  name           = local.ado_repository_name
  default_branch = "refs/heads/main"
  initialization {
    init_type = "Clean"
  }
}

resource "azuredevops_git_repository_branch" "branch" {
  depends_on    = [azuredevops_git_repository.repo]
  repository_id = azuredevops_git_repository.repo.id
  name          = "feature"
  ref_branch    = azuredevops_git_repository.repo.default_branch
}

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