% rebase('base')
<div class="bg-white shadow-sm rounded-lg">
    <div class="px-4 py-5 sm:px-6 flex justify-between items-center">
        <div>
            <h2 class="text-xl font-semibold leading-6 text-gray-900">Liste des tags</h2>
            <p class="mt-1 max-w-2xl text-sm text-gray-500">Gérez les étiquettes pour organiser vos documents</p>
        </div>
        % if isAdmin:
            <a href="/tags/create" class="inline-flex items-center rounded-md bg-primary px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-secondary">
                <i class="fas fa-plus mr-2"></i>
                Ajouter un tag
            </a>
        % end
    </div>

    <div class="border-t border-gray-200">
        % if tags:
            <ul role="list" class="divide-y divide-gray-200" data-pagination>
                % for tag in tags:
                    <li class="px-4 py-4 sm:px-6 hover:bg-gray-50" data-pagination-item>
                        <div class="flex items-center justify-between">
                            <div class="min-w-0 flex-1">
                                <div class="flex items-center gap-2">
                                    <a href="/tags/{{tag['id']}}" class="text-sm font-medium text-primary hover:text-secondary">
                                        <i class="fas fa-tag mr-2"></i>
                                        {{tag['name'].replace('_', ' ').title()}}
                                    </a>
                                </div>
                                <p class="mt-1 text-sm text-gray-500">Créé le {{tag['created_at'].strftime('%Y-%m-%d')}}</p>
                            </div>
                            % if isAdmin:
                                <div class="ml-4 flex flex-shrink-0 gap-2">
                                    <a href="/tags/{{tag['id']}}/edit" class="inline-flex items-center rounded-md bg-white px-2.5 py-1.5 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50">
                                        <i class="fas fa-edit mr-1"></i>
                                        Modifier
                                    </a>
                                    <form action="/tags/{{tag['id']}}/delete" method="post" class="inline">
                                        <button type="submit" 
                                                class="inline-flex items-center rounded-md bg-red-50 px-2.5 py-1.5 text-sm font-semibold text-red-700 shadow-sm ring-1 ring-inset ring-red-600/10 hover:bg-red-100"
                                                onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce tag ?')">
                                            <i class="fas fa-trash-alt mr-1"></i>
                                            Supprimer
                                        </button>
                                    </form>
                                </div>
                            % end
                        </div>
                    </li>
                % end
            </ul>
        % else:
            <div class="px-4 py-5 sm:px-6 text-center text-gray-500">
                <i class="fas fa-tags text-4xl mb-2"></i>
                <p>Aucun tag trouvé.</p>
                <p class="text-sm mt-2">Commencez par ajouter un nouveau tag</p>
            </div>
        % end
    </div>
</div>
