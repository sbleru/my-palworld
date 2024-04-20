# Google GitHub Workload Identity Terraform Module

このモジュールは、Google CloudのGitHub用Workload Identityリソースを作成するためのTerraformモジュールです。

## Features

- Workload Identity Poolの作成
- Workload Identity Pool Providerの作成
- サービスアカウントの作成
- サービスアカウントとリポジトリを紐づけ
- サービスアカウントにロールを付与

## Usage

```hcl-terraform
module "google_github_workload_identity" {
  source = "path/to/module/google_github_workload_identity"

  prefix                 = "your-prefix"
  project_id             = "your-project-id"
  github_repos           = ["your-repo1", "your-repo2"]
  service_account_name   = "your-service-account-name"
  service_account_roles  = ["roles/viewer", "roles/cloudbuild.builds.editor"]
}
```

## Variables

| Name                    | Description                           | Type           | Default                                                                                                                          | Required |
| ----------------------- | ------------------------------------- | -------------- | -------------------------------------------------------------------------------------------------------------------------------- | :------: |
| `prefix`                | リソース名のプレフィックス            | `string`       | "dev"                                                                                                                            |    no    |
| `project_id`            | Google CloudプロジェクトID            | `string`       | "bls-boost"                                                                                                                      |    no    |
| `github_repos`          | アクセスを許可するGitHubリポジトリ    | `list(string)` | n/a                                                                                                                              |   yes    |
| `service_account_name`  | サービスアカウント名                  | `string`       | "github"                                                                                                                         |    no    |
| `service_account_roles` | サービスアカウントに付与するIAMロール | `list(string)` | ["roles/viewer", "roles/cloudbuild.builds.editor", "roles/storage.admin", "roles/run.developer", "roles/iam.serviceAccountUser"] |    no    |

## Outputs

| Name                         | Description                        |
| ---------------------------- | ---------------------------------- |
| `service_account_account_id` | サービスアカウントの一意のID       |
| `service_account_email`      | サービスアカウントのメールアドレス |

## Requirements

- Terraform 1.6.0以上
- Google Provider 5.0以上
