pipeline {
    agent any
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
                                        echo "=== Старт ==="
                                        mkdir -p /opt/app/dev
                                        chmod -R 755 /opt/app/dev
                                        ls -la /opt/app/dev
                                        echo "=== Успешно ==="
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

