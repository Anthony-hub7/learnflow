% rebase('base')
<div class="bg-white shadow sm:rounded-lg">
    <div class="px-4 py-5 sm:px-6">
        <div class="flex justify-between items-start">
            <div>
                <h2 class="text-2xl font-bold leading-7 text-gray-900 sm:truncate sm:text-3xl sm:tracking-tight">
                    {{subject['name']}}
                </h2>
                <p class="mt-1 max-w-2xl text-sm leading-6 text-gray-500">
                    Catégorie : <span class="font-medium text-primary">{{subject['category_name']}}</span>
                </p>
                <p class="mt-1 max-w-2xl text-sm leading-6 text-gray-500">
                    Créée le {{subject['created_at']}}
                </p>
            </div>
            <div class="flex gap-3">
                <a href="/subjects/{{subject['id']}}/edit" 
                   class="inline-flex items-center rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50">
                    <i class="fas fa-edit mr-2"></i>
                    Modifier
                </a>
                <form action="/subjects/{{subject['id']}}/delete" method="post" class="inline">
                    <button type="submit" 
                            class="inline-flex items-center rounded-md bg-red-50 px-3 py-2 text-sm font-semibold text-red-700 shadow-sm ring-1 ring-inset ring-red-600/10 hover:bg-red-100"
                            onclick="return confirm('Confirmer la suppression ?')">
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
                    {{subject['description'] or 'Aucune description'}}
                </dd>
            </div>
        </dl>
    </div>
</div>

% if defined('documents') and documents:
    <div class="mt-8">
        <div class="sm:flex sm:items-center">
            <div class="sm:flex-auto">
                <h3 class="text-lg font-semibold text-gray-900">Documents de la matière</h3>
                <p class="mt-2 text-sm text-gray-700">Liste des ressources disponibles pour cette matière</p>
            </div>
            <div class="mt-4 sm:ml-16 sm:mt-0 sm:flex-none">
                <a href="/documents/create" class="inline-flex items-center rounded-md bg-primary px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-secondary">
                    <i class="fas fa-plus mr-2"></i>
                    Ajouter un document
                </a>
            </div>
        </div>
        <div class="mt-4 flow-root">
            <div class="-mx-4 -my-2 overflow-x-auto sm:-mx-6 lg:-mx-8">
                <div class="inline-block min-w-full py-2 align-middle sm:px-6 lg:px-8">
                    <div class="overflow-hidden shadow ring-1 ring-black ring-opacity-5 sm:rounded-lg">
                        <table class="min-w-full divide-y divide-gray-300">
                            <thead class="bg-gray-50">
                                <tr>
                                    <th scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">Type</th>
                                    <th scope="col" class="py-3.5 pl-4 pr-3 text-left text-sm font-semibold text-gray-900">Titre</th>
                                    <th scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">Description</th>
                                    <th scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">Créé le</th>
                                    <th scope="col" class="relative py-3.5 pl-3 pr-4 sm:pr-6">
                                        <span class="sr-only">Actions</span>
                                    </th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-200 bg-white">
                                % for doc in documents:
                                    <tr>
                                        <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500">
                                            <span class="inline-flex items-center rounded-md 
                                                % if doc['type'] == 'lesson':
                                                    bg-blue-50 px-2 py-1 text-xs font-medium text-blue-700 ring-1 ring-inset ring-blue-700/10
                                                % elif doc['type'] == 'exercise':
                                                    bg-green-50 px-2 py-1 text-xs font-medium text-green-700 ring-1 ring-inset ring-green-700/10
                                                % elif doc['type'] == 'exam':
                                                    bg-purple-50 px-2 py-1 text-xs font-medium text-purple-700 ring-1 ring-inset ring-purple-700/10
                                                % else:
                                                    bg-yellow-50 px-2 py-1 text-xs font-medium text-yellow-700 ring-1 ring-inset ring-yellow-700/10
                                                % end
                                            ">
                                                <i class="mr-1 fas 
                                                    % if doc['type'] == 'lesson':
                                                        fa-book-open
                                                    % elif doc['type'] == 'exercise':
                                                        fa-pencil-alt
                                                    % elif doc['type'] == 'exam':
                                                        fa-file-alt
                                                    % else:
                                                        fa-check
                                                    % end
                                                "></i>
                                                {{doc['type'].capitalize()}}
                                            </span>
                                        </td>
                                        <td class="whitespace-nowrap py-4 pl-4 pr-3 text-sm font-medium text-primary">
                                            <a href="/documents/{{doc['id']}}" class="hover:text-secondary">
                                                {{doc['title']}}
                                            </a>
                                        </td>
                                        <td class="px-3 py-4 text-sm text-gray-500">{{doc['description'] or 'Aucune description'}}</td>
                                        <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500">{{doc['created_at']}}</td>
                                        <td class="relative whitespace-nowrap py-4 pl-3 pr-4 text-right text-sm font-medium sm:pr-6">
                                            <div class="flex gap-2 justify-end">
                                                <a href="/documents/{{doc['id']}}/download" 
                                                   class="text-primary hover:text-secondary">
                                                    <i class="fas fa-download"></i>
                                                </a>
                                                <a href="/documents/{{doc['id']}}/edit"
                                                   class="text-gray-600 hover:text-gray-900">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <form action="/documents/{{doc['id']}}/delete" method="post" class="inline">
                                                    <button type="submit"
                                                            class="text-red-600 hover:text-red-900"
                                                            onclick="return confirm('Confirmer la suppression ?')">
                                                        <i class="fas fa-trash-alt"></i>
                                                    </button>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                % end
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
% else:
    <div class="mt-8 bg-white shadow sm:rounded-lg p-6 text-center text-gray-500">
        <i class="fas fa-file-alt text-4xl mb-4"></i>
        <p>Aucun document n'est associé à cette matière.</p>
        <a href="/documents/create" class="inline-flex items-center rounded-md bg-primary px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-secondary mt-4">
            <i class="fas fa-plus mr-2"></i>
            Ajouter un document
        </a>
    </div>
% end

<div class="mt-6">
    <a href="/subjects" class="inline-flex items-center rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50">
        <i class="fas fa-arrow-left mr-2"></i>
        Retour à la liste
    </a>
</div>
