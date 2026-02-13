@'
$ProjectRoot = "F:\iris-vein-vit"
$imageFolder = "F:\iris-vein-vit"

cd "$ProjectRoot\docker"
docker-compose down -v
docker-compose up -d zookeeper kafka postgres redis
Start-Sleep -Seconds 15
docker-compose up -d spark-master spark-worker
Start-Sleep -Seconds 10

python -c "
import sys
sys.path.append('F:/iris-vein-vit')
from src.utils.kafka_streamer import get_kafka
k = get_kafka()
iris_count = k.stream_iris('$imageFolder', limit=30)
vein_count = k.stream_vein('$imageFolder', limit=30)
print(f'Streamed {iris_count} iris, {vein_count} vein images')
"

docker-compose up -d airflow-webserver
Start-Sleep -Seconds 15

echo "========================================"
echo "Pipeline Running"
echo "Airflow: http://localhost:8081 (admin/admin)"
echo "Spark: http://localhost:8080"
echo "========================================"
cd $ProjectRoot
'@ | Out-File -FilePath scripts\run.ps1 -Encoding UTF8 -Force
