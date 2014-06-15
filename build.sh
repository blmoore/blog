# build static blog and copy to deploy
jekyll build
rm -r ~/other/blmoore.github.io/blog/*
cp -r _site/* ~/other/blmoore.github.io/blog/.
