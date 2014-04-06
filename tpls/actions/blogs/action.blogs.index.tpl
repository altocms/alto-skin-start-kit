{extends file="_index.tpl"}

{block name="layout_vars"}
    {$sMenuHeadItemSelect="blogs"}
{/block}

{block name="layout_content"}
    <div class="content-inner-panel">
        <div class="page-header">
            <h1>{$aLang.blogs}</h1>
        </div>
        <form action="" method="POST" id="form-blogs-search" onsubmit="return false;" class="search-item">
            <input type="text" placeholder="{$aLang.blogs_search_title_hint}" autocomplete="off" name="blog_title"
                   class="form-control" value=""
                   onkeyup="ls.timer.run('blog-search', ls.blog.searchBlogs, ['#form-blogs-search'], 1.5);">
        </form>
        <div id="blogs-list-search" style="display:none;"></div>
        <div id="blogs-list-original">
            {router page='blogs' assign=sBlogsRootPage}
            {include file='commons/common.blog_list.tpl' bBlogsUseOrder=true sBlogsRootPage=$sBlogsRootPage}
        </div>
    </div>
    <div class="content-inner-paging">
        {include file='commons/common.pagination.tpl' aPaging=$aPaging}
    </div>
{/block}
