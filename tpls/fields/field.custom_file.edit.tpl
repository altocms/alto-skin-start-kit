{if $oField}
    {$iFieldId=$oField->getFieldId()}
    <div class="form-group">
        {if $_aRequest.fields.$iFieldId}
            <label for="topic_delete_file_{$iFieldId}">
                <input type="checkbox" id="topic_delete_file_{$iFieldId}"
                       name="topic_delete_file_{$iFieldId}"
                       value="on"> &mdash; {$aLang.content_delete_file}
                ({$_aRequest.fields.$iFieldId.file_name|escape:'html'})
            </label>
        {/if}
        <label for="topic_upload_file">
            {$oField->getFieldName()}{if $_aRequest.fields.$iFieldId} ({$aLang.content_file_replace}){/if}
        </label>
        <input class="form-control" type="file" name="fields_{$iFieldId}" id="fields-{$iFieldId}">

        <p class="help-block">
            <small class="note">{$oField->getFieldDescription()}</small>
        </p>
    </div>
{/if}