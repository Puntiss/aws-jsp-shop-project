# Description
The JSP FrontEnd web application interacts seamlessly with AWS services, showcasing a smooth integration between the frontend interface and the serverless backend. Products are retrieved and inserted using AWS Lambda functions, ensuring efficient data management within the DynamoDB database.

Project Components:
- The AWS Lambda project responsible for retrieving products from the associated DynamoDB is available [here](https://github.com/Puntiss/java-retrieveAllProduct-AWSLambdaFunction).
- The AWS Lambda project handling the insertion of products into the DynamoDB can be found [here](https://github.com/Puntiss/java-readAndUploadProduct-AWSLambdaFunction).

TechStack:
- FE: JSP, Boostrap
- BE: Java, AWS

# Live Test
If you want to try live code you can visit the website [here](http://server1-env-1.eba-at33pbnq.us-east-1.elasticbeanstalk.com/).

# Usage and Modify
**0. Prerequisites:**

- Install [Java 11+](https://www.java.com/it/download/help/windows_manual_download.html) or check if already installed with `java -version`.
- Install [Maven 3.8.4+](https://maven.apache.org/install.html) or check if already installed with `mvn -v`.

**1. Configure AWS Lambda Functions:**
   
- Follow the detailed instructions provided in the GitHub projects linked above to configure the two AWS Lambda functions in your AWS account.

**3. Obtain API Gateway Link:**
   
- After downloading the code, obtain the deployed link of your AWS Gateway API.
- Add this link to the apiDeployLink property inside the file *src/main/java/com/appa/bean/ProductBean.java*.

**3. Install Project Dependencies:**
   
- Install all project dependencies specified in the *pom.xml* file using `mvn clean install`, a *target* folder will be created.

**5. Launch the Application:**
- Take the *.war* file obtained and host the website on a Tomcat or JBoss application server.
> [!NOTE]
> - In JBoss you can put the war file directly on the deployments folder
> - In Tomcat you have to upload the file in the `http://localhost:8080/manager` page and click deploy, if you want to avoid this step you have to insert inside the webapps folder the unzipped war.

**6. See result**
- Navigate to `http://localhost:8080/` in your browser to see the result.
   
Happy coding!


