pipeline {
	agent 
        {
        node 
            {
            label 'sunfire'
            }
        }
      steps
        {
        stage('Download TLD Data') 
            {
            steps 
                {
                sh '''
                    bash getdata.bash
                '''
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
}
