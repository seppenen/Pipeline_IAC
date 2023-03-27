// Azure DevOps build definition resource for creating pipelines
resource "azuredevops_build_definition" "pipeline" {
  for_each   = var.pipeline                // For each pipeline defined in the var.pipeline input variable
  project_id = azuredevops_project.this.id // Set the project ID to the ID of the current project
  name       = var.pipeline[each.key].name // Set the name of the build definition to the name of the pipeline

  // Create a CI trigger for the pipeline
  ci_trigger {
    use_yaml = true // Use YAML for the CI trigger
  }

  // Set up the repository for the pipeline
  repository {
    repo_type   = "TfsGit"                           // Use TfsGit as the repository type
    repo_id     = azuredevops_git_repository.repo.id // Set the repository ID to the ID of the current repository
    branch_name = var.pipeline[each.key].branch_name // Set the branch name to the name of the branch for the pipeline
    yml_path    = var.pipeline[each.key].yml_path    // Set the YAML file path to the path of the YAML file for the pipeline
  }

  // Set the dependency on the azuredevops_git_repository_file resource
  depends_on = [azuredevops_git_repository_file.file]
}

// Azure DevOps Git repository file resource for creating files in TfsGit repositories
resource "azuredevops_git_repository_file" "file" {
  for_each            = var.pipeline                                  // For each pipeline defined in the var.pipeline input variable
  repository_id       = azuredevops_git_repository.repo.id            // Set the repository ID to the ID of the current repository
  file                = var.pipeline[each.key].yml_path               // Set the name of the file to the name of the YAML file for the pipeline
  content             = file("../${var.pipeline[each.key].yml_path}") // Set the content of the file to the content of the YAML file for the pipeline
  branch              = var.pipeline[each.key].branch_name            // Set the branch name to the name of the branch for the pipeline
  commit_message      = "Init commit"                                 // Set the commit message for the initial commit
  overwrite_on_create = true                                          // Overwrite the file if it already exists
  depends_on          = [azuredevops_git_repository_branch.branch]    // Set the dependency on the azuredevops_git_repository_branch resource
}
