
//Pipeline build definitions

resource "azuredevops_build_definition" "pipeline" {
  for_each   = var.pipeline
  project_id = azuredevops_project.this.id
  name       = var.pipeline[each.key].name
  ci_trigger {
    use_yaml = true
  }

  repository {
    repo_type   = "TfsGit"
    repo_id     = azuredevops_git_repository.repo.id
    branch_name = var.pipeline[each.key].branch_name
    yml_path    = var.pipeline[each.key].yml_path
  }
  depends_on = [azuredevops_git_repository_file.file]
}


resource "azuredevops_git_repository_file" "file" {
  for_each            = var.pipeline
  repository_id       = azuredevops_git_repository.repo.id
  file                = var.pipeline[each.key].yml_path
  content             = file("../${var.pipeline[each.key].yml_path}")
  branch              = var.pipeline[each.key].branch_name
  commit_message      = "Init commit"
  overwrite_on_create = true
  depends_on          = [azuredevops_git_repository_branch.branch]
}
