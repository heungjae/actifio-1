oracle.xml
```
<app-class name="Oracle" description="Oracle Database" friendly-name="Oracle">
    <provisioning-options>
        <provisioning-option name="databasesid" type="string" label="Target Database SID" identity="true"
                             description="SID for target database" required="true"/>
        <provisioning-option name="username" type="string" label="User Name"
                            description="Oracle OS User name for database provisioning" group="login" required="true"/>
        <provisioning-option name="password" type="encrypt" label="Password"
                            description="Password for Oracle OS user" group="login" required="false"/>
        <provisioning-option name="orahome" type="string" label="Oracle Home Directory"
                             description="Oracle Home Directory on target machine" required="true"/>
        <provisioning-option name="tnsadmindir" type="string" label="TNS ADMIN Directory path"
                            description="TNS ADMIN Directory path (tnsnames.ora location path)" required="true"/>
        <provisioning-option name="totalmemory" type="long" label="Database Memory Size in MB"
                             description="Database total memory size in MB on target server" required="false"/>
        <provisioning-option name="sgapct" type="long" label="SGA %"  
                             description="Parameter to configure SGA/PGA memory when set" required="false"/>
        <provisioning-option name="tnsip" type="string" label="TNS Listener IP"
                            description="TNS Listener IP: SCAN, VIP, or Host IP "  required="false"/>
        <provisioning-option name="tnsport" type="long" label="TNS Listener port"
                            description="TNS Listener port (default 1521)"  required="false"/>
        <provisioning-option name="tnsdomain" type="string" label="TNS Domain Name"
                             description="TNS Listener Domain name" required="false"/>
        <provisioning-option name="rrecovery" type="boolean" label="Restore with Recovery" default-value="true"
                             description="Recover database after AppAware mount" required="false"/>
        <provisioning-option name="standalone" type="boolean" label="Stand Alone Non-RAC" default-value="false"
                             description="Clone a stand alone non_RAC instance" required="false"/>
        <provisioning-option name="envvar" type="string" label="Environment variable"
                            description="Environment variable can be separated by common delimiter" group="envar" required="false"/>
    </provisioning-options>
    <provisioning-script required="false" name="script name"/>
</app-class>

```

oracleGroup.xml
```
<app-class name="OracleGroup" friendly-name="Oracle Group" 
           description="Consistency group including one Oracle Database and optionally one or more filesystem applications">
    <provisioning-options>
        <provisioning-option name="ConsistencyGroupName" type="string" label="Name of Consistency Group" identity="true"
                             description="Name of Consistency Group" required="true"/>
        <provisioning-option name="databasesid" type="string" label="Target Database SID" identity="true"
                             description="SID for target database" required="true"/>
        <provisioning-option name="username" type="string" label="User Name"
                            description="Oracle OS User name for database provisioning" group="login" required="true"/>
        <provisioning-option name="password" type="encrypt" label="Password"
                            description="Password for Oracle OS user" group="login" required="false"/>
        <provisioning-option name="orahome" type="string" label="Oracle Home Directory"
                             description="Oracle Home Directory on target machine" required="true"/>
        <provisioning-option name="tnsadmindir" type="string" label="TNS ADMIN Directory path"
                            description="TNS ADMIN Directory path (tnsnames.ora location path)" required="true"/>
        <provisioning-option name="totalmemory" type="long" label="Database Memory Size in MB"
                             description="Database total memory size in MB on target server" required="false"/>
        <provisioning-option name="sgapct" type="long" label="SGA %"  
                             description="Parameter to configure SGA/PGA memory when set" required="false"/>
        <provisioning-option name="tnsip" type="string" label="TNS Listener IP"
                            description="TNS Listener IP: SCAN, VIP, or Host IP "  required="false"/>
        <provisioning-option name="tnsport" type="long" label="TNS Listener port"
                            description="TNS Listener port (default 1521)"  required="false"/>
        <provisioning-option name="tnsdomain" type="string" label="TNS Domain Name"
                             description="TNS Listener Domain name" required="false"/>
        <provisioning-option name="rrecovery" type="boolean" label="Restore with Recovery" default-value="true"
                             description="Recover database after AppAware mount" required="false"/>
        <provisioning-option name="standalone" type="boolean" label="Stand Alone Non-RAC" default-value="false"
                             description="Clone a stand alone non_RAC instance" required="false"/>
        <provisioning-option name="envvar" type="string" label="Environment variable"
                            description="Environment variable can be separated by common delimiter" group="envar" required="false"/>
    </provisioning-options>
    <provisioning-script required="false" name="script name"/>
</app-class>
```
