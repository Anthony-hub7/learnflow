% rebase('base.tpl')
<div class="bg-white shadow sm:rounded-lg">
    <div class="px-4 py-5 sm:px-6">
        <h1 class="text-2xl font-bold leading-7 text-gray-900 sm:tracking-tight">
            Résumé des tags
        </h1>
        <p class="mt-1 text-sm text-gray-500">
            Vue d'ensemble des tags et de leur utilisation
        </p>
    </div>

    <div class="border-t border-gray-200">
        <div class="px-4 py-5 sm:p-6">
            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-gray-300">
                    <thead>
                        <tr class="bg-gray-50">
                            <th scope="col" class="py-3.5 pl-4 pr-3 text-left text-sm font-semibold text-gray-900">Tag</th>
                            <th scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">Nombre de documents</th>
                            <th scope="col" class="relative py-3.5 pl-3 pr-4">
                                <span class="sr-only">Actions</span>
                            </th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-200 bg-white">
                        % for tag in tags:
                            <tr class="hover:bg-gray-50">
                                <td class="whitespace-nowrap py-4 pl-4 pr-3 text-sm font-medium text-gray-900">
                                    {{tag['name']}}
                                </td>
                                <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500">
                                    {{tag['document_count']}} document{{'s' if tag['document_count'] != 1 else ''}}
                                </td>
                                <td class="relative whitespace-nowrap py-4 pl-3 pr-4 text-right text-sm font-medium">
                                    <a href="/tags/{{tag['id']}}/documents" class="text-primary hover:text-secondary">
                                        Voir les documents →
                                    </a>
                                    % if session.get('isAdmin'):
                                        | <a href="/tags/{{tag['id']}}/edit" class="text-yellow-600 hover:text-yellow-900">Modifier</a>
                                        | <a href="/tags/{{tag['id']}}/delete" class="text-red-600 hover:text-red-900" onclick="return confirm('Supprimer ce tag ?');">Supprimer</a>
                                    % end
                                </td>
                            </tr>
                        % end
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
