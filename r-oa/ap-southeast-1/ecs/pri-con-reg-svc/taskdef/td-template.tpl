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