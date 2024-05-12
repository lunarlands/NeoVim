sudo git add .

echo "Commit:"
read commit
sudo git commit -m "$commit"

sudo git push -uf origin main