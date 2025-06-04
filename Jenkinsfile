pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                checkout scm  // Клонируем репозиторий
                sh 'ls -la'  // Проверяем, какие файлы есть в workspace
            }
        }
        stage('Deploy') {
            steps {
                sshPublisher(
                    publishers: [
                        sshPublisherDesc(
                            configName: "nemoserv",
                            transfers: [
                                sshTransfer(
                                    // Указываем, какие файлы копировать
                                    sourceFiles: "**/*",              // Все файлы из workspace
                                    remoteDirectory: "/opt/app/dev",  // Куда копировать на сервере
                                    // Команды после копирования
                                    execCommand: """
                                        echo "=== Файлы скопированы ==="
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
