"""
Serializers for recipe APIs
"""
from rest_framework import serializers

from core.models import Recipe

class RecipeSerializer(serializers.ModelSerializer):
    """Serializer for recipes."""

    class Meta:
        model = Recipe
        fields = ['id', 'title','time_minutes','price','link']
        read_only_fileds = ['id']

class RecipeDetailSerializer(RecipeSerializer):
    """Serializer for recipes detail view."""

    class Meta(RecipeSerializer.Meta):
        fields = RecipeSerializer.Meta.fields + ['description']
        