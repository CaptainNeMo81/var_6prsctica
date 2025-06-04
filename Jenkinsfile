pipeline {
    agent any
    options {
        timeout(time: 10, unit: 'MINUTES')  // Максимальное время выполнения
    }
    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', 
                         branches: [[name: '*/main']],
                         extensions: [[$class: 'CloneOption', timeout: 3]],  // Таймаут 3 мин
                         userRemoteConfigs: [[url: 'https://github.com/CaptainNeMo81/var_6prsctica.git']]
                ])
                sh 'ls -la > filelist.txt'  // Сохраняем список файлов
                archiveArtifacts 'filelist.txt'  // Сохраняем артефакт
            }
        }
        stage('Deploy') {
            steps {
                script {
                    try {
                        sshPublisher(
                            publishers: [
                                sshPublisherDesc(
                                    configName: "nemoserv",
                                    verbose: true,  // Подробный лог
                                    transfers: [
                                        sshTransfer(
                                            sourceFiles: "**/*",
                                            removePrefix: "",  // Важно для корректного копирования
                                            remoteDirectory: "/opt/app/dev",
                                            execCommand: """
                                                echo '### DEBUG ###'
                                                whoami
                                                pwd
                                                ls -la /opt/app/dev
                                                chmod -R 755 /opt/app/dev
                                            """
                                        )
                                    ]
                                )
                            ]
                        )
                    } catch (e) {
                        echo "Ошибка деплоя: ${e}"
                        currentBuild.result = 'FAILURE'
                    }
                }
            }
        }
    }
}
