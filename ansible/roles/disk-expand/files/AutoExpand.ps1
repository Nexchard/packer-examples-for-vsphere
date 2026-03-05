# AutoExpand.ps1 - 自动磁盘扩容脚本
Write-Host "Checking disk space and attempting expansion if needed..."

try {
    # 获取C盘信息
    $volume = Get-CimInstance -ClassName Win32_Volume -Filter "DriveLetter='C:'"
    $partition = Get-Partition -DriveLetter C
    
    # 获取最大可扩展大小
    $supportedSize = Get-PartitionSupportedSize -DriveLetter C
    $maxSize = $supportedSize.SizeMax
    
    # 比较当前大小与最大可扩展大小
    $currentSize = $volume.Capacity
    $sizeDifference = $maxSize - $currentSize
    
    if ($sizeDifference -gt 100MB) {  # 如果差值超过100MB，则执行扩容
        Write-Host "Current size: $([math]::Round($currentSize/1GB, 2)) GB"
        Write-Host "Maximum supported size: $([math]::Round($maxSize/1GB, 2)) GB"
        Write-Host "Expanding C: drive partition..."
        
        # 尝试使用Resize-Partition命令扩容
        Resize-Partition -DriveLetter C -Size $maxSize
        
        Write-Host "Successfully expanded C: drive partition."
    } else {
        Write-Host "C: drive is already at or near maximum size."
    }
} catch {
    Write-Error "Failed to expand C: drive: $($_.Exception.Message)"
}