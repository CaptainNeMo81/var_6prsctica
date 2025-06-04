pipeline {
    agent any

    parameters {
        choice(
            name: 'ENV',
            choices: ['dev', 'prod'],
            description: 'Куда деплоить?'
        )
    }

    stages {
        stage('Подготовка') {
            steps {
                echo "🔹 Деплой в ${params.ENV} на nemoserv:/opt/app/${params.ENV}"
                cleanWs()  // Очистка workspace
            }
        }

        stage('Копирование файлов') {
            steps {
                script {
                    // Проверка, что параметр ENV задан
                    if (!params.ENV) {
                        error("Параметр ENV не выбран!")
                    }

                    // Копирование через SSH
                    sshPublisher(
                        publishers: [
                            sshPublisherDesc(
                                configName: 'nemoserv-ssh',  // Должен быть настроен в Jenkins
                                transfers: [
                                    sshTransfer(
                                        sourceFiles: '**/*',  // Все файлы из репозитория
                                        removePrefix: '',      // Не обрезать пути
                                        remoteDirectory: "/opt/app/${params.ENV}",
                                        execCommand: """
                                            echo '✅ Файлы скопированы в /opt/app/${params.ENV}'
                                            chmod -R 755 /opt/app/${params.ENV}
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

    post {
        success {
            echo "🎉 Успешный деплой в ${params.ENV}!"
        }
        failure {
            echo "❌ Ошибка деплоя в ${params.ENV}"
        }
    }
}
