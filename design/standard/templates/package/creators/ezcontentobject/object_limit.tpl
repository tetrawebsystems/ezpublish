<div id="package" class="create">
    <div id="sid-{$current_step.id|wash}" class="pc-{$creator.id|wash}">

    <form method="post" action={'package/create'|ezurl}>

    {include uri="design:package/create/error.tpl"}

    {include uri="design:package/header.tpl"}

    <p>{"Specify export properties. Default settings will most likely be suitable for your needs."|i18n("design/package/creators/ezcontentobject")}</p>


    <label>{"Miscellaneous"|i18n("design/package/creators/ezcontentobject")}</label>

    <input class="checkbox" type="checkbox" Name="IncludeClasses" value="1" {section show=$options.include_classes}checked="checked"{/section} />
        {"Include class definitions."|i18n("design/package/creators/ezcontentobject")}<br />

    <input class="checkbox" type="checkbox" Name="IncludeTemplates" value="1" {section show=$options.include_templates}checked="checked"{/section} />
        {"Include templates related exported objects."|i18n("design/package/creators/ezcontentobject")}<br />
	{"Select templates from the following siteaccesses"|i18n("design/package/creators/ezcontentobject")}<br />
	<select size="3" name="SiteAccesses[]" multiple="multiple">
	    {section loop=$available_site_accesses}
	        <option value="{$:item}" {section show=$options.site_access_array|contains($:item)}selected="selected"{/section}>{$:item}</option>
	    {/section}
	</select><br />


    <label>{"Versions"|i18n("design/package/creators/ezcontentobject")}</label>

    <input class="radio" type="radio" Name="VersionExport" value="current" {section show=$options.versions|eq("current")}checked="checked"{/section} />
        {"Published version"|i18n("design/package/creators/ezcontentobject")}<br />

    <input class="radio" type="radio" Name="VersionExport" value="all" {section show=$options.versions|eq("all")}checked="checked"{/section} />
        {"All versions"|i18n("design/package/creators/ezcontentobject")}<br />


    <label>{"Languages"|i18n("design/package/creators/ezcontentobject")}</label>

    {"Select languages to export"|i18n("design/package/creators/ezcontentobject")}<br />
    <select size="5" name="Languages[]" multiple="multiple">
	{section loop=$available_languages}
	    <option value="{$:item.locale|wash}" {section show=$options.language_array|contains($:item.locale)}selected="selected"{/section}>{$:item.name|wash}</option>
	{/section}
    </select><br />


    <label>{"Node assignments"|i18n("design/package/creators/ezcontentobject")}</label>

    <input class="radio" type="radio" Name="NodeAssignment" value="selected" {section show=$options.node_assignment|eq("selected")}checked="checked"{/section} />
        {"Keep all in selected nodes"|i18n("design/package/creators/ezcontentobject")}<br />

    <input class="radio" type="radio" Name="NodeAssignment" value="main" {section show=$options.node_assignment|eq("main")}checked="checked"{/section} />
        {"Main only"|i18n("design/package/creators/ezcontentobject")}<br />
	

    <label>{"Related objects"|i18n("design/package/creators/ezcontentobject")}</label>

    <input class="radio" type="radio" Name="RelatedObjects" value="selected" {section show=$options.related_objects|eq("selected")}checked="checked"{/section} />
        {"Keep all in selected nodes"|i18n("design/package/creators/ezcontentobject")}<br />

    <input class="radio" type="radio" Name="RelatedObjects" value="none" {section show=$options.related_objects|eq("none")}checked="checked"{/section} />
        {"None"|i18n("design/package/creators/ezcontentobject")}<br />


    {include uri="design:package/navigator.tpl"}

    </form>

    </div>
</div>
