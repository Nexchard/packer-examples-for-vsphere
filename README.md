本项目fork自[vmware/packer-examples-for-vsphere: Packer Examples for vSphere](https://github.com/vmware/packer-examples-for-vsphere)

进行了本地环境适配性修改：

修改内容如下：

- ansible--roles目录新增admin-password（用于重置root、administrator用户密码）、disk-expand（用于自动扩容Windows系统C盘）两个roles；
- ansible的configure角色在处理debian系的操作系统时，在grub启动时添加"net.ifnames=0 biosdevname=0"，用于固定网卡名称；
- 调整enable_cloudinit == 'true'使ansible能够正确配置及清理系统模板；
- 调整builds/common.pkrvars.hcl.example中common_vm_version的值，使本项目得以支持vsphere7.0环境；
- 调整builds目录下部分系统linux-*.pkrvars.hcl.example文件中vm_guest_os_type的值，使本项目得以支持vsphere7.0环境；
- 调整rocky和Ubuntu系统linux-*.pkr.hcl文件中关于 boot_command的设置，用以支持无DHCP环境下的模板制作；
- 调整builds目录下所有系统的vm_guest_os_timezone的默认值，用以调整模板中系统的时区；
- 调整scripts/windows/windows-init.ps1文件，增加telnet组件安装以及 Azure Arc Setup组件卸载。


> 如需根据实际环境修改linux-*.pkr.hcl文件中关于 boot_command的设置
