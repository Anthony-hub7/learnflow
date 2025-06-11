% if defined('pagination'):
<nav aria-label="Navigation des pages" class="mt-4">
    <ul class="pagination justify-content-center">
        <li class="page-item {{'disabled' if not pagination['has_prev'] else ''}}">
            <a class="page-link" href="?page={{pagination['current_page']-1}}" {{'tabindex="-1" aria-disabled="true"' if not pagination['has_prev'] else ''}}>Précédent</a>
        </li>
        
        % for i in range(max(1, pagination['current_page']-2), min(pagination['total_pages']+1, pagination['current_page']+3)):
        <li class="page-item {{'active' if i == pagination['current_page'] else ''}}">
            <a class="page-link" href="?page={{i}}">{{i}}</a>
        </li>
        % end
        
        <li class="page-item {{'disabled' if not pagination['has_next'] else ''}}">
            <a class="page-link" href="?page={{pagination['current_page']+1}}" {{'tabindex="-1" aria-disabled="true"' if not pagination['has_next'] else ''}}>Suivant</a>
        </li>
    </ul>
</nav>

<div class="text-center mt-2">
    <small class="text-muted">
        Page {{pagination['current_page']}} sur {{pagination['total_pages']}} 
        ({{pagination['total_items']}} éléments)
    </small>
</div>
% end
