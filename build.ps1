Remove-Item target\*.pdf

docker build -t tf7 .
docker run tf7

$out = docker ps -a |Select-String "tf7"
foreach ($line in $out){
  $ids = $line.line -split " "
  $id = ${ids}[0]
  & docker cp ${id}:/tmp/code/target .
  docker rm $id
}

