rm ./build/deploy.zip

dart compile exe ./lib/bin/handler.dart -o ./build/handler 

chmod -R 777 ./build/handler

zip -j ./build/deploy.zip ./lib/bin/bootstrap ./build/handler

python ./deploy/upload-zip.py
