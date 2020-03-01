pipeline {
	agent 
        {
        node 
            {
            label 'zerozero'
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
	 stage('Decompress TLD Data')
            {
            steps
                {
                sh '''
                    bash decompress.bash
                '''
                }
            }
	 stage('Import to MongoDB')
            {
            steps
                {
                sh '''
                    bash process-mongo.bash
                '''
                }
            }
	 stage('Convert to csv')
            {
            steps
                {
                sh '''
                    bash process-csv.bash
                '''
                }
            }
	 stage('Split csv (90m)')
            {
            steps
                {
                sh '''
                    bash process-splitcsv.bash
                '''
                }
            }
        }
    }

