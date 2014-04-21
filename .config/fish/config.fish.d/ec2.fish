if test -d "/usr/local/Library/LinkedKegs/ec2-api-tools"
  set -x "JAVA_HOME" (/usr/libexec/java_home)
  set -x "EC2_PRIVATE_KEY" (/bin/ls "$HOME"/.ec2/pk-*.pem | /usr/bin/head -1)
  set -x "EC2_CERT" (ls "$HOME/.ec2/"cert-*.pem | /usr/bin/head -1)
  set -x "EC2_HOME" "/usr/local/Library/LinkedKegs/ec2-api-tools/jars"
  set -x "EC2_URL" "https://us-west-2.ec2.amazonaws.com/"
end
