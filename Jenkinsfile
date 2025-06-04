pipeline {
    agent any
    parameters {
        string(name: 'ENV', defaultValue: 'dev', description: 'Target environment (dev, prod, etc.)')
    }
    stages {
        stage('Deploy') {
            steps {
                sshPublisher(
                    publishers: [
                        sshPublisherDesc(
                            configName: "nemoserv",
                            transfers: [
                                sshTransfer(
                                    execCommand: """
                                        mkdir -p /opt/app/dev || echo "Directory already exists"
                                        chmod -R 755 /opt/app/dev || echo "Failed to set permissions"
                                        echo "Deployment to ${params.ENV} completed!"
                                    """
                                )
                            ]
                        )
                    ]
                )
            }
        }
    }
}
