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
