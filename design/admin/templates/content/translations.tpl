<form name="languageform" action={$module.functions.translations.uri|ezurl} method="post" >

<div class="context-block">
<h2 class="context-title">{'Available translation languages [%translations_count]'|i18n( 'design/admin/content/translations',, hash( '%translations_count', $existing_translations|count ) )}</h2>

<table class="list" cellspacing="0">
<tr>
    <th class="tight"><img src={'toggle-button-16x16.gif'|ezimage} alt="{'Invert selection.'|i18n( 'design/admin/node/view/full' )}" title="{'Invert selection.'|i18n( 'design/admin/node/view/full' )}" onclick="ezjs_toggleCheckboxes( document.languageform, 'DeleteIDArray[]' ); return false;"/></th>
    <th>{'Language'|i18n( 'design/admin/content/translations' )}</th>
	<th>{'Country'|i18n( 'design/admin/content/translations' )}</th>
	<th>{'Locale'|i18n( 'design/admin/content/translations' )}</th>
</tr>

{section var=Translations loop=$existing_translations sequence=array( bglight, bgdark )}
<tr class="{$Translations.sequence}">
    {* Remove. *}
	<td><input type="checkbox" name="DeleteIDArray[]" value="{$Translations.item.id}" {section show=$Translations.index|not}disabled="disabled" title="{'The default translation can not be removed.'|i18n( 'design/admin/content/translations' )}" {/section} /></td>

    {* Language. *}
	<td>
    {'translation'|icon( 'small', 'Translation'|i18n( 'design/admin/content/translations' ) )}
    {section show=$Translations.item.name}
        {$Translations.item.name|wash}
    {section-else}
        {$Translations.item.locale_object.intl_language_name|wash}
    {/section}
    </td>

    {* Country. *}
	<td>{$Translations.item.locale_object.country_name|wash}</td>

    {* Locale. *}
	<td>{$Translations.item.locale_object.locale_code|wash}</td>
</tr>
{/section}
</table>

<div class="controlbar">
<div class="block">
<input class="button" type="submit" name="RemoveButton" value="{'Remove selected'|i18n('design/admin/content/translations')}" />
<input class="button" type="submit" name="NewButton"    value="{'Add language'|i18n('design/admin/content/translations')}" />
</div>
</div>

</div>

</form>
