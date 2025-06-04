pipeline {
    agent any
    parameters {
        choice(name: 'ENV', choices: ['dev', 'prod'], description: 'Target environment')
    }
    stages {
        stage('Deploy') {
            steps {
                echo "Deploying to ${params.ENV}"
                deleteDir()  // Очистка рабочей директории
                
                // Копирование файлов через SSH
                sshPublisher(
                    publishers: [
                        sshPublisherDesc(
                            configName: 'nemoserv',  // Имя SSH-сервера из настроек Jenkins
                            transfers: [
                                sshTransfer(
                                    sourceFiles: '**/*',  // Все файлы
                                    remoteDirectory: "/opt/app/${params.ENV}",  // Папка на сервере
                                    removePrefix: '',      // Не обрезать префикс пути
                                    execCommand: 'chmod -R 755 /opt/app/${params.ENV}'  // Доп. команда
                                )
                           ],
                            usePromotionTimestamp: false,
                            verbose: true
                        )
                    ]
                )
            }
        }
    }
}
