<form id="photoset-upload-form" method="POST" enctype="multipart/form-data" onsubmit="return false;"
      class="modal modal-image-upload">
    <header class="modal-header">
        <h3>{$aLang.uploadimg}</h3>
        <a href="#" class="close jqmClose"></a>
    </header>

    <div id="topic-photo-upload-input" class="topic-photo-upload-input modal-content">
        <label for="photoset-upload-file">{$aLang.topic_photoset_choose_image}:</label>
        <input type="file" id="photoset-upload-file" name="Filedata"/><br><br>

        <button type="submit" class="button button-primary"  onclick="ls.photoset.upload();">
            {$aLang.topic_photoset_upload_choose}
        </button>
        <button type="submit" class="button"  onclick="ls.photoset.closeForm();">
            {$aLang.topic_photoset_upload_close}
        </button>

        <input type="hidden" name="is_iframe" value="true"/>
        <input type="hidden" name="topic_id" value="{$_aRequest.topic_id}"/>
    </div>
</form>
