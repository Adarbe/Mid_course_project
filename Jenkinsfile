node {
  def app = ""
      stage("pull code") {
	 repo = git "https://github.com/Adarbe/card_validation.git"

      stage('Docker build ') {
	app = docker.build( "adarbe/card_validation:${repo.GIT_COMMIT}_${BUILD_NUMBER}")
	withDockerRegistry(credentialsId: 'dockerhub.adarbe') {
        app.push()
		}
      }
      stage("build docker") {
        app = docker.build("dockerhub.adarbe")
        withDockerRegistry(credentialsId: 'dockerhub.adarbe') {
          }
        }
      stage('Apply Kubernetes files') {
	      withAWS(region: 'us-east-1', credentials: "jenkins" ) {              	
		    sh """
          aws configure
	        aws eks update-kubeconfig --name opsSchool-eks-png1TYK2
	        kubectl apply -f app.yml
	        """				
    	      }
      	}
}
}    


