date=$(date)
pull=$(git pull)
push=$(git push)

git add .
git commit -m "$date" .

echo "$pull"
echo "$push"