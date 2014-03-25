<script type="text/javascript">
    jQuery(document).ready(function($){
        $("a[rel^='prettyPhoto']").prettyPhoto({
            social_tools:'',
            show_title: false,
            slideshow:true,
            deeplinking: false
        });

        $('.topic-photoset-list').rowGrid({
            itemSelector: '.topic-photoset-item',
            minMargin: 10,
            maxMargin: 15,
            resize: false,
            lastRowClass: 'topic-photoset-last_row',
            firstItemClass: "first-item"
        });
    });
</script>

<div class="topic-photoset">
    {if count($aPhotos)<$oTopic->getPhotosetCount()}
    <h4>{$oTopic->getPhotosetCount()} {$oTopic->getPhotosetCount()|declension:$aLang.topic_photoset_count_images}</h4>
    {/if}
    <a name="photoset"></a>

    <ul class="topic-photoset-list list-unstyled list-inline clearfix">
        {if count($aPhotos)}
            {foreach $aPhotos as $oPhoto}
                <li class="topic-photoset-item">
                    <a class="topic-photoset-image" href="{$oPhoto->getUrl(1000)}" rel="prettyPhoto"  title="{$oPhoto->getDescription()}">
                        <img src="{$oPhoto->getUrl('x100')}" {$oPhoto->getImgSizeAttr('x100')} alt="{$oPhoto->getDescription()}" class="" />
                    </a>
                </li>
                {$iLastPhotoId=$oPhoto->getId()}
            {/foreach}
        {/if}
        <script type="text/javascript">
            ls.photoset.idLast='{$iLastPhotoId}';
        </script>
    </ul>

    {if count($aPhotos)<$oTopic->getPhotosetCount()}
        <a href="#" id="topic-photo-more" class="btn btn-info btn-large btn-block topic-photo-more" onclick="ls.photoset.getMore('{$oTopic->getId()}'); return false;">
            {$aLang.topic_photoset_show_more} &darr;
        </a>
    {/if}
</div>
