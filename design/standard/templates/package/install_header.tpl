    <input type="hidden" name="InstallItemID" value="{$installer.id|wash}" />
    <input type="hidden" name="InstallStepID" value="{$current_step.id|wash}" />
    <input type="hidden" name="PackageStep" value="1" />

    <h1>{'Package install wizard: %wizardname'|i18n( 'design/standard/package',, hash( '%wizardname', $creator.name|wash ) )}</h1>

    {section show=$persistent_data.thumbnail}
        <img src={$persistent_data.thumbnail.url|ezroot} alt="{$persistent_data.thumbnail.filename|wash}" />
    {/section}

    <h2>{$current_step.name|wash}</h2>
