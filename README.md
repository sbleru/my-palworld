# my-palworld

## Getting Started

GCPアカウントの準備

```sh
gcloud config configurations create my-palworld
gcloud init
gcloud auth application-default login
```

## Deployment

wip

```sh
gcloud builds submit --config=./tooling/docker/api/cloudbui
ld.yaml
export API_GCP_PROJECT=your_project_id
export API_GCP_REGION=asia-northeast1
gcloud run services update dev-api --image gcr.io/$API_GOOGLE_PROJECT/api:latest --region $API_GCP_REGION
```
