% rebase('base')

<div class="bg-white shadow sm:rounded-lg">
    <div class="px-4 py-5 sm:px-6">
        <div class="flex justify-between items-start">
            <div>
                <h2 class="text-2xl font-bold leading-7 text-gray-900 sm:truncate sm:text-3xl sm:tracking-tight">
                    {{category['name']}}
                </h2>
                <p class="mt-1 max-w-2xl text-sm leading-6 text-gray-500">
                    Créée le {{category['created_at']}}
                </p>
            </div>
            <div class="flex gap-3">
                <a href="/categories/{{category['id']}}/edit" class="inline-flex items-center rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50">
                    <i class="fas fa-edit mr-2"></i>
                    Modifier
                </a>
                <form action="/categories/{{category['id']}}/delete" method="post" class="inline">
                    <button type="submit" class="inline-flex items-center rounded-md bg-red-50 px-3 py-2 text-sm font-semibold text-red-700 shadow-sm ring-1 ring-inset ring-red-600/10 hover:bg-red-100" onclick="return confirm('Confirmer la suppression ?')">
                        <i class="fas fa-trash-alt mr-2"></i>
                        Supprimer
                    </button>
                </form>
            </div>
        </div>
    </div>
    <div class="border-t border-gray-100">
        <dl class="divide-y divide-gray-100">
            <div class="px-4 py-6 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                <dt class="text-sm font-medium leading-6 text-gray-900">Description</dt>
                <dd class="mt-1 text-sm leading-6 text-gray-700 sm:col-span-2 sm:mt-0">
                    {{category['description'] or 'Aucune description'}}
                </dd>
            </div>
        </dl>
    </div>
</div>

% if defined('subjects') and subjects:
    <div class="mt-8">
        <h3 class="text-lg font-medium leading-6 text-gray-900 mb-4">Matières dans cette catégorie</h3>
        <div class="bg-white shadow overflow-hidden sm:rounded-md">
            <ul role="list" class="divide-y divide-gray-200">
                % for subj in subjects:
                    <li>
                        <div class="px-4 py-4 sm:px-6 hover:bg-gray-50">
                            <div class="flex items-center justify-between">
                                <div class="min-w-0 flex-1">
                                    <a href="/subjects/{{subj['id']}}" class="text-sm font-medium text-primary hover:text-secondary">
                                        <i class="fas fa-book mr-2"></i>
                                        {{subj['name']}}
                                    </a>
                                    % if subj.get('description'):
                                        <p class="mt-1 text-sm text-gray-500">{{subj['description']}}</p>
                                    % end
                                </div>
                                <div class="ml-4 flex flex-shrink-0 gap-2">
                                    <a href="/subjects/{{subj['id']}}/edit" class="inline-flex items-center rounded-md bg-white px-2.5 py-1.5 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50">
                                        <i class="fas fa-edit mr-1"></i>
                                        Modifier
                                    </a>
                                    <form action="/subjects/{{subj['id']}}/delete" method="post" class="inline">
                                        <button type="submit" class="inline-flex items-center rounded-md bg-red-50 px-2.5 py-1.5 text-sm font-semibold text-red-700 shadow-sm ring-1 ring-inset ring-red-600/10 hover:bg-red-100">
                                            <i class="fas fa-trash-alt mr-1"></i>
                                            Supprimer
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </li>
                % end
            </ul>
        </div>
    </div>
% else:
    <div class="mt-8 bg-white shadow sm:rounded-lg p-6 text-center text-gray-500">
        <i class="fas fa-book text-4xl mb-2"></i>
        <p>Aucune matière dans cette catégorie.</p>
    </div>
% end

<div class="mt-6">
    <a href="/categories" class="inline-flex items-center rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50">
        <i class="fas fa-arrow-left mr-2"></i>
        Retour à la liste
    </a>
</div>
