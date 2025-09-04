[
  {
    "name": "${containerName}",
    "image": "${image}",
    "portMappings": [
      {
        "name": "${portName}", 
        "containerPort": ${containerPort}
      }
    ],

    "environment": [
      {
        "name": "REGISTRY_STORAGE",
        "value": "s3"
      },
      {
        "name": "REGISTRY_STORAGE_S3_REGION",
        "value": "ap-southeast-1"
      },
      {
        "name": "REGISTRY_STORAGE_S3_BUCKET",
        "value": "storage-s3-r-oa-pri-con-reg"
      },
      {
        "name": "REGISTRY_STORAGE_S3_ROOTDIRECTORY",
        "value": "/docker"
      }
    ],

    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${loggroup}",
        "awslogs-region": "ap-southeast-1",
        "awslogs-stream-prefix": "ecs"
      }
    }
  }
]
