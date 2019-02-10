$endpoint = 'jomitsf.westus.cloudapp.azure.com:19000'
$thumbprint = '<CertThumbprint>'

# Connect to the cluster using a client certificate.
Connect-ServiceFabricCluster -ConnectionEndpoint $endpoint `
          -KeepAliveIntervalInSec 10 `
          -X509Credential -ServerCertThumbprint $thumbprint `
          -FindType FindByThumbprint -FindValue $thumbprint `
          -StoreLocation CurrentUser -StoreName My

$AppPath = "$PSScriptRoot\MultipleNamedAppInstances\pkg\Debug"

# Copy the application package to the cluster image store.
Copy-ServiceFabricApplicationPackage -ApplicationPackagePath $AppPath -ImageStoreConnectionString fabric:ImageStore -ApplicationPackagePathInImageStore MultipleNamedAppInstances

# Register the application type.
Register-ServiceFabricApplicationType -ApplicationPathInImageStore MultipleNamedAppInstances

# Create the application instance.
New-ServiceFabricApplication -ApplicationName fabric:/MultipleNamedAppInstances -ApplicationTypeName MultipleNamedAppInstancesType -ApplicationTypeVersion 1.0.0

# Create the application for "Tenant1"
#New-ServiceFabricApplication -ApplicationName fabric:/MultipleNamedAppInstances/Tenant1 -ApplicationTypeName MultipleNamedAppInstancesType -ApplicationTypeVersion 1.0.0

# Create the application for "Tenant2"
#New-ServiceFabricApplication -ApplicationName fabric:/MultipleNamedAppInstances/Tenant2 -ApplicationTypeName MultipleNamedAppInstancesType -ApplicationTypeVersion 1.0.0

