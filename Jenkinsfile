pipeline {
	agent 
        {
        node 
            {
            label 'sunfire'
            }
        }
	environment {
  
		    }
      stages 
        {
        stage('Git Pull') 
            {
            steps 
                {
                sh '''
                   # apt-get update
                    # apt-get install ${DEPENDENCIES} -y
		git clone git@gitlab.wsad.io:client-repos/wsad/open-tld-zonefile-build.git --recurse-submodules
                '''
                }
        }
        stage('Download TLD Data') 
            {
            steps 
                {
                sh '''
                    ls
                '''
                }
        }
    }
}
