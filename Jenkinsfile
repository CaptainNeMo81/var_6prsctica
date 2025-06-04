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
                                        chmod -R 755 /opt/app/
                                        # Другие команды...
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
