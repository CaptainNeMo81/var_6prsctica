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
                                    // 1. Копируем файлы из workspace Jenkins на сервер
                                    sourceFiles: "**/*",              // Что копируем (все файлы из workspace)
                                    remoteDirectory: "/opt/app/dev",  // Куда копируем
                                    // 2. Выполняем команды после копирования
                                    execCommand: """
                                        echo "Файлы скопированы в /opt/app/dev/"
                                        ls -la /opt/app/dev           // Проверим содержимое
                                        chmod -R 755 /opt/app/dev     // Даём права
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
