# #!/usr/bin/env bash
# # Add user information to git global config. This allows Jenkins to push updates to github repos
# echo "Setting up github creds"
# git config --global user.email "adarza@gmail.com"
# git config --global user.name "adarbe"


# echo "Starting SSH Agent..."
# eval "$(ssh-agent -s)"
# ssh-add ~/.ssh/id_rsa

# echo "Please add the following public key to a github account at https://github.com/settings/keys"
# echo ""
# cat ~/.ssh/id_rsa.pub
# echo ""
# echo "After you add the key to your profile, try and clone a repo"
# echo ""
# echo "git clone git@github.com:OGProgrammer/jenkins-pipeline-groovy.git /tmp/test"
# echo ""
# echo "You will be prompted to check the fingerprint of github."
# echo "If you're paranoid about MITM attacks, verify the fingerprint at:"
# echo "https://help.github.com/articles/github-s-ssh-key-fingerprints/"
# echo "Type 'yes' and hit enter if they match and you are all set"