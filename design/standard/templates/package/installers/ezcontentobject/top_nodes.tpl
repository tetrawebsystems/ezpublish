<div id="package" class="create">
    <div id="sid-{$current_step.id|wash}" class="pc-{$installer.id|wash}">

    <form method="post" action={'package/install'|ezurl}>

    {include uri="design:package/install/error.tpl"}

    {include uri="design:package/install_header.tpl"}

    <p>{'Please select placement of top nodes.'|i18n('design/standard/package')}</p>


    <label>{'Browse to select placement.'|i18n('design/standard/package')}</label>
    
    {section loop=$top_nodes_map}
      <div class="block">{$:item.name|wash}: {$:item.new_parent_name} ( {$:item.new_node_id} )
        &nbsp;<input class="button" type="submit" Name="{concat('BrowseNode_', $:item.old_node_id)}" value="{"Browse"|i18n("design/package")}" />
      </div>
    {/section}

    {include uri="design:package/navigator.tpl"}

    </form>

    </div>
</div>