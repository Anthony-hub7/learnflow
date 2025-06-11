% rebase('base.tpl')
<div class="bg-white shadow sm:rounded-lg">
    <div class="px-4 py-5 sm:px-6">
        <div class="flex items-center justify-between">
            <div>
                <h1 class="text-2xl font-bold leading-7 text-gray-900 sm:tracking-tight">
                    <i class="fas fa-tags mr-2 text-primary"></i>
                    Tags du document
                </h1>
                <p class="mt-1 text-sm text-gray-500">{{document_title}}</p>
            </div>
            <a href="/tags/summary" 
               class="inline-flex items-center rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50">
                <i class="fas fa-chart-pie mr-2"></i>
                Vue d'ensemble des tags
            </a>
        </div>
    </div>

    <div class="border-t border-gray-200 px-4 py-5 sm:p-6">
        % if tags:
            <div class="mb-6">
                <h2 class="text-sm font-medium text-gray-700 mb-3 flex items-center">
                    <i class="fas fa-bookmark mr-2 text-primary"></i>
                    Tags actuels
                </h2>
                <div class="flex flex-wrap gap-2">
                    % for tag in tags:
                        <div class="group inline-flex items-center gap-2 rounded-md bg-primary/10 px-2 py-1 text-sm font-medium text-primary ring-1 ring-inset ring-primary/20 hover:bg-primary/20 transition-colors duration-200">
                            <i class="fas fa-tag text-xs"></i>
                            {{tag['name']}}
                            % if isAdmin:
                                <form action="/documents/{{document_id}}/tags/{{tag['id']}}" method="post" class="inline">
                                    <input type="hidden" name="_method" value="DELETE">
                                    <button type="submit" 
                                            onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce tag ?');"
                                            class="ml-1 inline-flex h-4 w-4 items-center justify-center rounded-full text-primary hover:bg-primary/30 focus:outline-none transition-colors duration-200">
                                        <i class="fas fa-times text-xs"></i>
                                    </button>
                                </form>
                            % end
                        </div>
                    % end
                </div>
            </div>
        % else:
            <div class="mb-6 text-center py-6 bg-gray-50 rounded-lg">
                <i class="fas fa-tags text-4xl text-gray-400 mb-2"></i>
                <p class="text-sm text-gray-500">Aucun tag associé à ce document</p>
            </div>
        % end

        <div class="space-y-6">
            <div>
                <h2 class="text-sm font-medium text-gray-700 mb-3 flex items-center">
                    <i class="fas fa-plus-circle mr-2 text-primary"></i>
                    Ajouter des tags
                </h2>
                % if isAdmin:
                    <form action="/documents/{{document_id}}/tags" method="post">
                        <div class="mt-2 grid grid-cols-1 gap-4 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4">
                            % for tag in all_tags:
                                <label class="relative flex items-start p-2 rounded-lg hover:bg-gray-50 transition-colors duration-200">
                                    <div class="flex h-6 items-center">
                                        <input type="checkbox" 
                                               name="tag_ids[]" 
                                               value="{{tag['id']}}"
                                               % if any(t['id'] == tag['id'] for t in tags):
                                                   disabled checked
                                               % end
                                               class="h-4 w-4 rounded border-gray-300 text-primary focus:ring-primary disabled:opacity-50">
                                    </div>
                                    <div class="ml-3 text-sm leading-6">
                                        <span class="font-medium text-gray-900">{{tag['name']}}</span>
                                    </div>
                                </label>
                            % end
                        </div>
                        <div class="mt-6 flex justify-end gap-3">
                            <a href="/documents/{{document_id}}" 
                               class="inline-flex items-center rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50">
                                <i class="fas fa-arrow-left mr-2"></i>
                                Retour au document
                            </a>
                            <button type="submit"
                                    class="inline-flex items-center rounded-md bg-primary px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-secondary focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-primary">
                                <i class="fas fa-save mr-2"></i>
                                Enregistrer les modifications
                            </button>
                        </div>
                    </form>
                % else:
                    <div class="mt-6 flex justify-end">
                        <a href="/documents/{{document_id}}" 
                           class="inline-flex items-center rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50">
                            <i class="fas fa-arrow-left mr-2"></i>
                            Retour au document
                        </a>
                    </div>
                % end
            </div>
        </div>
    </div>
</div>
