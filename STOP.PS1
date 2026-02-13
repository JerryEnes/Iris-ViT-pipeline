@'
cd "F:\iris-vein-vit\docker"
docker-compose down
docker system prune -f
echo "Pipeline stopped"
'@ | Out-File -FilePath scripts\stop.ps1 -Encoding UTF8 -Force
