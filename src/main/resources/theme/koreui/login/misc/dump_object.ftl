<!-- source: https://stackoverflow.com/a/54842966/9028985 -->
<#macro dump_object object debug=false>
    <#compress>
        <#if object??>
            <#attempt>
                <#if object?is_node>
                    <#if object?node_type == "text">${object}
                    <#else>&lt;${object?node_name}<#if object?node_type=="element" && object.@@?has_content><#list object.@@ as attr>
                        ${attr?node_name}="${attr}"</#list></#if>&gt;
                        <#if object?children?has_content><#list object?children as item>
                            <@dump_object object=item/></#list><#else>${object}</#if> &lt;/${object?node_name}&gt;</#if>
                <#elseif object?is_method>
                    #method
                <#elseif object?is_sequence>
                    [<#list object as item><@dump_object object=item/><#if !item?is_last>, </#if></#list>]
                <#elseif object?is_hash_ex>
                    {<#list object as key, item>${key}=<@dump_object object=item/><#if !item?is_last>, </#if></#list>}
                <#else>
                    "${object?string}"
                </#if>
                <#recover>
                    <#if !debug><!-- </#if>LOG: Could not parse object <#if debug><pre>${.error}</pre><#else>--></#if>
            </#attempt>
        <#else>
            null
        </#if>
    </#compress>
</#macro>