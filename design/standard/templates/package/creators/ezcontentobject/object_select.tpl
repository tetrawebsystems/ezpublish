<div id="package" class="create">
    <div id="sid-{$current_step.id|wash}" class="pc-{$creator.id|wash}">

    <form method="post" action={'package/create'|ezurl}>

    {include uri="design:package/create/error.tpl"}

    {include uri="design:package/header.tpl"}

    <p>{'Please choose objects you wish to include in the package.'|i18n('design/standard/package')}</p>


    <label>{'Selected nodes'|i18n('design/standard/package')}</label>
    <table class="list" width="100%" cellpadding="0" cellspacing="0" border="0">
	<tr>
	    <th>{"Node"|i18n("design/standard/class/list")}</th>
	    <th>{"Export type"|i18n("design/standard/class/list")}</th>
	    <th>{"Remove"|i18n("design/standard/class/list")}</th>
	</tr>
        {section var=node loop=$node_list}
	    <tr>
	        <td class="{$node.sequence}">{fetch(content,node,hash(node_id,$node.item.id)).name|wash}</td>
		<td class="{$node.sequence}">{$node.item.type}</td>
		<td class="{$node.sequence}" width="1" align="right"><input type="checkbox" name="DeleteIDArray[]" value="{$node.item.id}"></td>
	    </tr>
	{/section}
    </table>

    <div class="block">
        <input class="button" type="submit" Name="AddSubtree" value="{"Add subtree"|i18n("design/package/creators/ezcontentobject")}" />
        <input class="button" type="submit" Name="AddNode" value="{"Add node"|i18n("design/package/creators/ezcontentobject")}" />
        <input class="button" type="submit" Name="RemoveSelected" value="{"Remove selected"|i18n("design/package/creators/ezcontentobject")}" />
    </div>

    {include uri="design:package/navigator.tpl"}

    </form>

    </div>
</div>
