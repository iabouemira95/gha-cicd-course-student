SECRETS_FILE="secrets.env"
source ./.env
readonly MAIN_REPO_NAME="gha-cicd-course-student"
readonly MAIN_REPO_FORK_NAME="gha-cicd-course-student-fork"
readonly MAIN_REPO="https://github.com/iabouemira95/$MAIN_REPO_NAME.git"

readonly FILE=/etc/os-release

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root (use sudo)."
   exit 1
fi

function install_gh_debian(){
    (type -p wget >/dev/null || (sudo apt update && sudo apt install wget -y)) \
	&& sudo mkdir -p -m 755 /etc/apt/keyrings \
	&& out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
	&& cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& sudo mkdir -p -m 755 /etc/apt/sources.list.d \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh -y
}


function install_gh_redhat(){
    VERSION=$(curl -s https://api.github.com/repos/cli/cli/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | cut -c 2-)
    ARCH=$(uname -m)

    RPM_URL="https://github.com/cli/cli/releases/download/v${VERSION}/gh_${VERSION}_linux_${ARCH}.rpm"

    if rpm -ivh "$RPM_URL"; then
        echo "Successfully installed gh via RPM."
    else
        echo "RPM installation failed. Falling back to DNF repository method..."

        # 2. Fallback: DNF Repository Method
        if command -v dnf &> /dev/null; then
            dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
            dnf install gh -y
        else
            # Older RHEL/CentOS systems using YUM
            yum-config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
            yum install gh -y
        fi

        if [ $? -eq 0 ]; then
            echo "Successfully installed gh via DNF/YUM."
        else
            echo "Installation failed. Please check your internet connection or repository permissions."
            exit 1
        fi
    fi
}


if [ -f $FILE ]; then
    . $FILE
else
    echo "OS release file cannot be found"
    exit 1
fi

if ! which gh > /dev/null 2>&1; then
    if [[ "$ID" == "rhel" || "$ID_LIKE" == *"rhel"* ]]; then
        install_gh_redhat
    elif [[ "$ID" == "debian" || "$ID_LIKE" == *"debian"* ]]; then
        install_gh_debian
    else
        echo "Distro not identified: $ID"
        exit 1
    fi
fi

gh --version

if [[ "$DEPLOY_VM" == "true" ]]; then
    cat ./08-final-deployment-assessment-vm.yml >> ./.github/workflows/08-final-deployment-assessment-cd.yml
else
    cat ./08-final-deployment-assessment-ci.yml >> ./.github/workflows/08-final-deployment-assessment-cd.yml
fi

export GH_TOKEN="$GIT_HUB_PASSWORD"
GIT_HUB_PAT="$GH_TOKEN"
echo "$GIT_HUB_PAT" | gh auth login --with-token

git config --global user.name "$GIT_HUB_USERNAME"
git config --global user.email "$GIT_HUB_EMAIL"
git config --global credential.helper store
echo "https://$GIT_HUB_USERNAME:$GIT_HUB_PASSWORD@github.com" > ~/.git-credentials

gh repo fork iabouemira95/gha-cicd-course-student --clone --fork-name $MAIN_REPO_FORK_NAME

gh api -X PUT /repos/$GIT_HUB_USERNAME/$MAIN_REPO_FORK_NAME/collaborators/iabouemira95 \
  -f permission=Push
gh api -X PUT /repos/$GIT_HUB_USERNAME/$MAIN_REPO_FORK_NAME/collaborators/KerolosAyman308 \
  -f permission=Push
# to fix the last secret dont populate
sed -i -e '$a\' "$SECRETS_FILE"
while IFS='=' read -r key value; do
    if [[ -z "$key" || "$key" == \#* ]]; then
        continue
    fi

    key=$(echo "$key" | xargs)

    if [[ -z "$value" ]]; then
        echo "Warning: No value provided for $key. Skipping..."
        continue
    fi
    
    echo -n "$value" | gh secret set "$key" --repo "$GIT_HUB_USERNAME/$MAIN_REPO_FORK_NAME"

done < "$SECRETS_FILE"

git clone https://github.com/$GIT_HUB_USERNAME/$MAIN_REPO_FORK_NAME.git
gh repo set-default "$GIT_HUB_USERNAME/$MAIN_REPO_FORK_NAME"

cp ./.github/workflows/08-final-deployment-assessment.yml ./$MAIN_REPO_FORK_NAME/.github/workflows
cp ./.github/workflows/08-final-deployment-assessment-cd.yml ./$MAIN_REPO_FORK_NAME/.github/workflows
pushd ./$MAIN_REPO_FORK_NAME
git add .
git commit -m "Add final task"
git push
popd

gh api -X PUT /repos/$GIT_HUB_USERNAME/$MAIN_REPO_FORK_NAME/branches/main/protection \
  --input - <<EOF
{
  "enforce_admins": true,
  "required_pull_request_reviews": {
    "required_approving_review_count": 2,
    "dismiss_stale_reviews": false,
    "require_code_owner_reviews": false
  },
  "required_status_checks": {
    "strict": false,
    "contexts": ["ci_final_assessment"]
  },
  "restrictions": null
}
EOF

## simulate a PR
pushd ./$MAIN_REPO_FORK_NAME
git checkout -b newbranch
cp ../newtestfile.sh ./newtestfile.sh
git add .
git commit -m "Add test PR"
git push -u origin newbranch

gh pr create \
--title "Deploy newbranch" \
--base main \
--head newbranch \
--body "new pr test" \
--repo "$GIT_HUB_USERNAME/$MAIN_REPO_FORK_NAME" 

popd

