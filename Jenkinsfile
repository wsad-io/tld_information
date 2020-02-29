pipeline {
	agent 
        {
        node 
            {
            label 'sunfire'
            }
        }
      stages
        {
	 stage('Build Fresh ICANN Java Client')
            {
            steps
                {
                sh '''
                    bash buildclient.bash
                '''
                }
            }
        stage('Download TLD Data from ICANN') 
            {
            steps 
                {
                sh '''
                    bash getdata.bash
                '''
                }
	    }
	stage('Process TLD Data')
	   {
	   steps
		{
		sh '''
		   bash process.bash
		'''
		}
	   }
        }
    }

